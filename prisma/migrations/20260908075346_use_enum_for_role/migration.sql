/*
  Warnings:

  - The primary key for the `Availability` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `UniqueID` on the `Availability` table. All the data in the column will be lost.
  - The primary key for the `Employee` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `UniqueID` on the `Employee` table. All the data in the column will be lost.
  - The primary key for the `ScheduleAssignment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `UniqueID` on the `ScheduleAssignment` table. All the data in the column will be lost.
  - The primary key for the `ScheduleEntry` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `UniqueID` on the `ScheduleEntry` table. All the data in the column will be lost.
  - The primary key for the `Shifts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `UniqueID` on the `Shifts` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `RoleID` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `UniqueID` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Roles` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'EMPLOYEE');

-- DropForeignKey
ALTER TABLE "Availability" DROP CONSTRAINT "Availability_EmployeeID_fkey";

-- DropForeignKey
ALTER TABLE "Availability" DROP CONSTRAINT "Availability_ShiftID_fkey";

-- DropForeignKey
ALTER TABLE "ScheduleAssignment" DROP CONSTRAINT "ScheduleAssignment_EmployeeID_fkey";

-- DropForeignKey
ALTER TABLE "ScheduleAssignment" DROP CONSTRAINT "ScheduleAssignment_ScheduleEntryID_fkey";

-- DropForeignKey
ALTER TABLE "ScheduleEntry" DROP CONSTRAINT "ScheduleEntry_ShiftID_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_EmployeeID_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_RoleID_fkey";

-- AlterTable
ALTER TABLE "Availability" DROP CONSTRAINT "Availability_pkey",
DROP COLUMN "UniqueID",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Availability_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Employee" DROP CONSTRAINT "Employee_pkey",
DROP COLUMN "UniqueID",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Employee_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "ScheduleAssignment" DROP CONSTRAINT "ScheduleAssignment_pkey",
DROP COLUMN "UniqueID",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "ScheduleAssignment_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "ScheduleEntry" DROP CONSTRAINT "ScheduleEntry_pkey",
DROP COLUMN "UniqueID",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "ScheduleEntry_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Shifts" DROP CONSTRAINT "Shifts_pkey",
DROP COLUMN "UniqueID",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Shifts_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "RoleID",
DROP COLUMN "UniqueID",
ADD COLUMN     "Role" "Role" NOT NULL DEFAULT 'EMPLOYEE',
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "Roles";

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_ShiftID_fkey" FOREIGN KEY ("ShiftID") REFERENCES "Shifts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleEntry" ADD CONSTRAINT "ScheduleEntry_ShiftID_fkey" FOREIGN KEY ("ShiftID") REFERENCES "Shifts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleAssignment" ADD CONSTRAINT "ScheduleAssignment_ScheduleEntryID_fkey" FOREIGN KEY ("ScheduleEntryID") REFERENCES "ScheduleEntry"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleAssignment" ADD CONSTRAINT "ScheduleAssignment_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
