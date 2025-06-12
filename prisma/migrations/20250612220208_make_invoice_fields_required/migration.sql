/*
  Warnings:

  - Made the column `companyId` on table `sales` required. This step will fail if there are existing NULL values in that column.
  - Made the column `subtotal` on table `sales` required. This step will fail if there are existing NULL values in that column.
  - Made the column `taxAmount` on table `sales` required. This step will fail if there are existing NULL values in that column.
  - Made the column `taxRate` on table `sales` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "sales" DROP CONSTRAINT "sales_companyId_fkey";

-- AlterTable
ALTER TABLE "sales" ALTER COLUMN "companyId" SET NOT NULL,
ALTER COLUMN "subtotal" SET NOT NULL,
ALTER COLUMN "taxAmount" SET NOT NULL,
ALTER COLUMN "taxRate" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
