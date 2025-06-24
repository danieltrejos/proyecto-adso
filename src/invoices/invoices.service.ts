/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-argument */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { CreateInvoiceDto, InvoiceQueryDto } from './dto/create-invoice.dto';
import { UpdateInvoiceDto } from './dto/update-invoice.dto';
import { SalesService } from '../sales/sales.service';
import { TDocumentDefinitions } from 'pdfmake/interfaces';

// Simple pdfmake import
const pdfMake = require('pdfmake/build/pdfmake');
const pdfFonts = require('pdfmake/build/vfs_fonts');

// Configure pdfMake
pdfMake.vfs = pdfFonts.pdfMake.vfs;

@Injectable()
export class InvoicesService {
  constructor(private readonly salesService: SalesService) {}

  async create(createInvoiceDto: CreateInvoiceDto) {
    if (!createInvoiceDto.saleId) {
      throw new BadRequestException('ID de venta es requerido para generar factura');
    }

    const sale = await this.salesService.findOneForInvoice(createInvoiceDto.saleId);

    if (!sale.invoiceNumber) {
      throw new BadRequestException('La venta no tiene número de factura asignado');
    }

    return {
      message: 'Factura encontrada',
      invoice: this.mapSaleToInvoice(sale)
    };
  }
  async findAll(query: InvoiceQueryDto = {}) {
    // Convertir strings a números si es necesario
    const page = Number(query.page) || 1;
    const limit = Number(query.limit) || 10;
    const customerId = query.customerId ? Number(query.customerId) : undefined;
    const userId = query.userId ? Number(query.userId) : undefined;

    const sales = await this.salesService.findAll();

    // Filtrar ventas que tienen invoiceNumber
    let invoices = sales
      .filter((sale) => sale.invoiceNumber)
      .map((sale) => this.mapSaleToInvoice(sale));

    // Aplicar filtros si existen
    if (query.invoiceNumber) {
      invoices = invoices.filter((invoice) =>
        invoice.invoiceNumber.toLowerCase().includes(query.invoiceNumber!.toLowerCase())
      );
    }

    if (customerId) {
      invoices = invoices.filter((invoice) => invoice.customerId === customerId);
    }

    if (userId) {
      invoices = invoices.filter((invoice) => invoice.userId === userId);
    }

    if (query.startDate) {
      const startDate = new Date(query.startDate);
      invoices = invoices.filter((invoice) => new Date(invoice.createdAt) >= startDate);
    }

    if (query.endDate) {
      const endDate = new Date(query.endDate);
      endDate.setHours(23, 59, 59, 999); // Incluir todo el día
      invoices = invoices.filter((invoice) => new Date(invoice.createdAt) <= endDate);
    }

    // Aplicar paginación
    const startIndex = (page - 1) * limit;
    const endIndex = startIndex + limit;
    const paginatedInvoices = invoices.slice(startIndex, endIndex);

    return {
      invoices: paginatedInvoices,
      total: invoices.length,
      page,
      limit,
      totalPages: Math.ceil(invoices.length / limit)
    };
  }

  async findOne(id: number) {
    const sale = await this.salesService.findOneForInvoice(id);

    if (!sale.invoiceNumber) {
      throw new NotFoundException('Factura no encontrada para esta venta');
    }

    return this.mapSaleToInvoice(sale);
  }
  async findBySaleId(saleId: number) {
    return this.findOne(saleId);
  }
  async downloadPDF(saleId: number): Promise<Buffer> {
    const sale = await this.salesService.findOneForInvoice(saleId);

    if (!sale.invoiceNumber) {
      throw new NotFoundException('Factura no encontrada para esta venta');
    }

    const pdfDoc = this.generatePDFDefinition(sale);

    return new Promise((resolve, reject) => {
      try {
        const pdfDocGenerator = pdfMake.createPdf(pdfDoc);

        pdfDocGenerator.getBuffer((buffer: Buffer) => {
          resolve(buffer);
        });
      } catch (error) {
        reject(error instanceof Error ? error : new Error('Error desconocido al generar PDF'));
      }
    });
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  update(_id: number, _updateInvoiceDto: UpdateInvoiceDto) {
    throw new BadRequestException('Las facturas no pueden ser modificadas');
  }

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  remove(_id: number) {
    throw new BadRequestException('Las facturas no pueden ser eliminadas');
  }

  private mapSaleToInvoice(sale: any) {
    return {
      id: sale.id as number,
      invoiceNumber: sale.invoiceNumber as string,
      total: sale.total as number,
      subtotal: sale.subtotal as number,
      taxAmount: sale.taxAmount as number,
      taxRate: sale.taxRate as number,
      paymentAmount: sale.paymentAmount as number,
      change: sale.change as number,
      paymentMethod: sale.paymentMethod as string,
      createdAt: sale.createdAt as Date,
      updatedAt: sale.updatedAt as Date,
      userId: sale.userId as number,
      customerId: sale.customerId as number | undefined,
      companyId: sale.companyId as string,
      user: sale.user,
      customer: sale.customer,
      company: sale.company,
      saleItems: sale.items || [] // Mapear items a saleItems
    };
  }

  private generatePDFDefinition(sale: any): TDocumentDefinitions {
    const company = sale.company;
    const customer = sale.customer;
    const items = sale.items || [];

    return {
      content: [
        // Header con datos de empresa
        {
          text: [
            { text: company?.name || 'Sistemas Web', style: 'companyName' },
            '\n',
            `${company?.street || 'Km 9 Carretera Nueva León, 150MTS Noreste'}\n`,
            `${company?.city || 'Managua'}, ${company?.state || 'Nicaragua'}\n`,
            `Tel: ${company?.phone || '123456789'}\n`,
            `Email: ${company?.email || 'fantasiasexshopasto@gmail.com'}`
          ],
          alignment: 'right',
          margin: [0, 0, 0, 20]
        },

        // Título de Factura
        {
          text: 'FACTURAR A',
          style: 'sectionTitle',
          margin: [0, 20, 0, 10]
        },

        // Información del cliente y factura
        {
          text: [
            { text: customer?.name || 'Cliente General', style: 'customerName' },
            '\n',
            `${customer?.address || 'Dirección no especificada'}\n`,
            `Teléfono: ${customer?.phone || 'No especificado'}\n`,
            `Email: ${customer?.email || 'No especificado'}\n\n`,
            { text: `Factura N°: ${sale.invoiceNumber}`, style: 'invoiceNumber' },
            '\n',
            `Fecha: ${new Date(sale.createdAt).toLocaleDateString('es-ES')}`
          ],
          margin: [0, 0, 0, 20]
        },

        // Total destacado
        {
          text: `TOTAL $ ${sale.total.toFixed(2)}`,
          style: 'totalAmount',
          alignment: 'right',
          margin: [0, 0, 0, 20]
        },

        // Tabla de productos
        {
          table: {
            headerRows: 1,
            widths: ['auto', '*', 'auto', 'auto'],
            body: [
              [
                { text: 'CANT.', style: 'tableHeader' },
                { text: 'DESCRIPCIÓN', style: 'tableHeader' },
                { text: 'PRECIO UNIT.', style: 'tableHeader' },
                { text: 'SUBTOTAL', style: 'tableHeader' }
              ],

              ...items.map((item: any) => [
                { text: item.quantity.toString(), alignment: 'center' },
                { text: item.product?.name || 'Producto', alignment: 'left' },
                { text: `${item.price.toFixed(2)}`, alignment: 'right' },
                { text: `${(item.quantity * item.price).toFixed(2)}`, alignment: 'right' }
              ])
            ]
          },
          layout: {
            fillColor: function (rowIndex: number) {
              return rowIndex === 0 ? '#FFA500' : null;
            }
          },
          margin: [0, 0, 0, 20]
        },

        // Resumen de totales
        {
          table: {
            widths: ['*', 'auto'],
            body: [
              [
                { text: 'SUBTOTAL $', style: 'summaryLabel' },
                { text: `${sale.subtotal.toFixed(2)}`, style: 'summaryValue' }
              ],
              [
                { text: `IVA ${sale.taxRate.toFixed(2)}% $`, style: 'summaryLabel' },
                { text: `${sale.taxAmount.toFixed(2)}`, style: 'summaryValue' }
              ],
              [
                { text: 'TOTAL $', style: 'summaryLabelBold' },
                { text: `${sale.total.toFixed(2)}`, style: 'summaryValueBold' }
              ]
            ]
          },
          layout: 'noBorders',
          alignment: 'right',
          margin: [0, 0, 0, 30]
        },

        // Mensaje de agradecimiento
        {
          text: 'Gracias por su compra!',
          style: 'thankYou',
          alignment: 'center',
          margin: [0, 20, 0, 0]
        }
      ],

      styles: {
        companyName: {
          fontSize: 18,
          bold: true,
          color: '#1f4e79'
        },
        companyInfo: {
          fontSize: 10,
          color: '#666666'
        },
        sectionTitle: {
          fontSize: 14,
          bold: true,
          color: '#1f4e79'
        },
        customerName: {
          fontSize: 12,
          bold: true
        },
        invoiceNumber: {
          fontSize: 12,
          bold: true,
          color: '#FFA500'
        },
        totalAmount: {
          fontSize: 18,
          bold: true,
          color: '#1f4e79'
        },
        tableHeader: {
          fontSize: 10,
          bold: true,
          color: '#FFFFFF',
          fillColor: '#FFA500'
        },
        summaryLabel: {
          fontSize: 10,
          alignment: 'right'
        },
        summaryValue: {
          fontSize: 10,
          alignment: 'right'
        },
        summaryLabelBold: {
          fontSize: 12,
          bold: true,
          alignment: 'right'
        },
        summaryValueBold: {
          fontSize: 12,
          bold: true,
          alignment: 'right'
        },
        thankYou: {
          fontSize: 14,
          bold: true,
          color: '#1f4e79'
        }
      },

      defaultStyle: {
        fontSize: 10,
        color: '#333333'
      },

      pageMargins: [40, 60, 40, 60]
    };
  }
}
