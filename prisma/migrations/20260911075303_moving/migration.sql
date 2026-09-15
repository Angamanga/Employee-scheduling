/*
  Warnings:

  - You are about to drop the column `LoginCode` on the `Employee` table. All the data in the column will be lost.
  - Added the required column `LoginCode` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Employee" DROP COLUMN "LoginCode";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "LoginCode" TEXT NOT NULL;
