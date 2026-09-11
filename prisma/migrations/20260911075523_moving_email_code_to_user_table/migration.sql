/*
  Warnings:

  - You are about to drop the column `Email` on the `Employee` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[Email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `Email` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Employee_Email_key";

-- AlterTable
ALTER TABLE "Employee" DROP COLUMN "Email";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "Email" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "User_Email_key" ON "User"("Email");
