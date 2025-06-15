export class Invoice {
    id: number;
    invoiceNumber: string;
    total: number;
    subtotal: number;
    taxAmount: number;
    taxRate: number;
    paymentAmount: number;
    change: number;
    paymentMethod: string;
    createdAt: Date;
    updatedAt: Date;

    // Relaciones
    userId: number;
    customerId?: number;
    companyId: string;

    user?: {
        id: number;
        name: string;
        email: string;
        role: string;
    };

    customer?: {
        id: number;
        name: string;
        email?: string;
        phone?: string;
        address?: string;
    };

    company?: {
        id: string;
        name: string;
        registrationNumber: string;
        email: string;
        phone?: string;
        logo?: string;
        street: string;
        city: string;
        state: string;
        postalCode: string;
        country: string;
    };

    items?: {
        id: number;
        quantity: number;
        price: number;
        product: {
            id: number;
            name: string;
            description?: string;
        };
    }[];
}
