-- CreateTable
CREATE TABLE "Employee" (
    "UniqueID" SERIAL NOT NULL,
    "Firstname" TEXT NOT NULL,
    "Lastname" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "LoginCode" TEXT NOT NULL,
    "PhotoURL" TEXT,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "Roles" (
    "UniqueID" SERIAL NOT NULL,
    "RoleName" TEXT NOT NULL,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "User" (
    "UniqueID" SERIAL NOT NULL,
    "RoleID" INTEGER NOT NULL,
    "EmployeeID" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "Shifts" (
    "UniqueID" SERIAL NOT NULL,
    "ShiftName" TEXT NOT NULL,
    "StartTime" TIMESTAMP(3) NOT NULL,
    "EndTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Shifts_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "Availability" (
    "UniqueID" SERIAL NOT NULL,
    "Day" TIMESTAMP(3) NOT NULL,
    "ShiftID" INTEGER NOT NULL,
    "Available" BOOLEAN NOT NULL,
    "EmployeeID" INTEGER NOT NULL,

    CONSTRAINT "Availability_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "ScheduleEntry" (
    "UniqueID" SERIAL NOT NULL,
    "Day" TIMESTAMP(3) NOT NULL,
    "ShiftID" INTEGER NOT NULL,

    CONSTRAINT "ScheduleEntry_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateTable
CREATE TABLE "ScheduleAssignment" (
    "UniqueID" SERIAL NOT NULL,
    "ScheduleEntryID" INTEGER NOT NULL,
    "EmployeeID" INTEGER NOT NULL,

    CONSTRAINT "ScheduleAssignment_pkey" PRIMARY KEY ("UniqueID")
);

-- CreateIndex
CREATE UNIQUE INDEX "Employee_Email_key" ON "Employee"("Email");

-- CreateIndex
CREATE UNIQUE INDEX "Roles_RoleName_key" ON "Roles"("RoleName");

-- CreateIndex
CREATE UNIQUE INDEX "User_EmployeeID_key" ON "User"("EmployeeID");

-- CreateIndex
CREATE UNIQUE INDEX "Availability_EmployeeID_ShiftID_Day_key" ON "Availability"("EmployeeID", "ShiftID", "Day");

-- CreateIndex
CREATE UNIQUE INDEX "ScheduleEntry_ShiftID_Day_key" ON "ScheduleEntry"("ShiftID", "Day");

-- CreateIndex
CREATE UNIQUE INDEX "ScheduleAssignment_ScheduleEntryID_EmployeeID_key" ON "ScheduleAssignment"("ScheduleEntryID", "EmployeeID");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_RoleID_fkey" FOREIGN KEY ("RoleID") REFERENCES "Roles"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_ShiftID_fkey" FOREIGN KEY ("ShiftID") REFERENCES "Shifts"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleEntry" ADD CONSTRAINT "ScheduleEntry_ShiftID_fkey" FOREIGN KEY ("ShiftID") REFERENCES "Shifts"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleAssignment" ADD CONSTRAINT "ScheduleAssignment_ScheduleEntryID_fkey" FOREIGN KEY ("ScheduleEntryID") REFERENCES "ScheduleEntry"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleAssignment" ADD CONSTRAINT "ScheduleAssignment_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employee"("UniqueID") ON DELETE RESTRICT ON UPDATE CASCADE;
