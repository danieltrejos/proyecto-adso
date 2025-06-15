/*
  Warnings:

  - A unique constraint covering the columns `[invoiceNumber]` on the table `sales` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "customers" ADD COLUMN     "address" TEXT;

-- AlterTable
ALTER TABLE "sales" ADD COLUMN     "companyId" TEXT,
ADD COLUMN     "invoiceNumber" TEXT,
ADD COLUMN     "subtotal" DOUBLE PRECISION,
ADD COLUMN     "taxAmount" DOUBLE PRECISION,
ADD COLUMN     "taxRate" DOUBLE PRECISION;

-- CreateTable
CREATE TABLE "currencies" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "precision" INTEGER NOT NULL DEFAULT 2,
    "thousandSeparator" TEXT NOT NULL DEFAULT ',',
    "decimalSeparator" TEXT NOT NULL DEFAULT '.',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "taxes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "currencies_code_key" ON "currencies"("code");

-- CreateIndex
CREATE UNIQUE INDEX "sales_invoiceNumber_key" ON "sales"("invoiceNumber");

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
