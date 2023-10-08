-- CreateTable
CREATE TABLE `Patient` (
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `salt` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `phone_number` VARCHAR(191) NULL,
    `birthdate` DATETIME(3) NULL,

    PRIMARY KEY (`email`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MedicalHistory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `date` DATETIME(3) NOT NULL,
    `conditions` VARCHAR(191) NOT NULL,
    `surgeries` VARCHAR(191) NOT NULL,
    `medication` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Doctor` (
    `email` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `salt` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone_number` VARCHAR(191) NULL,

    PRIMARY KEY (`email`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Appointment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `doctorEmail` VARCHAR(191) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `starttime` DATETIME(3) NOT NULL,
    `endtime` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PatientsAttendAppointments` (
    `patientEmail` VARCHAR(191) NOT NULL,
    `appointmentId` INTEGER NOT NULL,
    `concerns` VARCHAR(191) NOT NULL,
    `symptoms` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`patientEmail`, `appointmentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Schedule` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `starttime` DATETIME(3) NOT NULL,
    `endtime` DATETIME(3) NOT NULL,
    `breaktime` DATETIME(3) NOT NULL,
    `day` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PatientMedicalHistory` (
    `patientEmail` VARCHAR(191) NOT NULL,
    `historyId` INTEGER NOT NULL,

    PRIMARY KEY (`patientEmail`, `historyId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Diagnoses` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `appointmentId` INTEGER NOT NULL,
    `doctorEmail` VARCHAR(191) NOT NULL,
    `diagnosis` VARCHAR(191) NOT NULL,
    `prescription` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DocsHaveSchedules` (
    `scheduleId` INTEGER NOT NULL,
    `doctorEmail` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`scheduleId`, `doctorEmail`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DoctorViewsHistory` (
    `historyId` INTEGER NOT NULL,
    `doctorEmail` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`historyId`, `doctorEmail`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_doctorEmail_fkey` FOREIGN KEY (`doctorEmail`) REFERENCES `Doctor`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PatientsAttendAppointments` ADD CONSTRAINT `PatientsAttendAppointments_patientEmail_fkey` FOREIGN KEY (`patientEmail`) REFERENCES `Patient`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PatientsAttendAppointments` ADD CONSTRAINT `PatientsAttendAppointments_appointmentId_fkey` FOREIGN KEY (`appointmentId`) REFERENCES `Appointment`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PatientMedicalHistory` ADD CONSTRAINT `PatientMedicalHistory_patientEmail_fkey` FOREIGN KEY (`patientEmail`) REFERENCES `Patient`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PatientMedicalHistory` ADD CONSTRAINT `PatientMedicalHistory_historyId_fkey` FOREIGN KEY (`historyId`) REFERENCES `MedicalHistory`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Diagnoses` ADD CONSTRAINT `Diagnoses_appointmentId_fkey` FOREIGN KEY (`appointmentId`) REFERENCES `Appointment`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Diagnoses` ADD CONSTRAINT `Diagnoses_doctorEmail_fkey` FOREIGN KEY (`doctorEmail`) REFERENCES `Doctor`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DocsHaveSchedules` ADD CONSTRAINT `DocsHaveSchedules_scheduleId_fkey` FOREIGN KEY (`scheduleId`) REFERENCES `Schedule`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DocsHaveSchedules` ADD CONSTRAINT `DocsHaveSchedules_doctorEmail_fkey` FOREIGN KEY (`doctorEmail`) REFERENCES `Doctor`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DoctorViewsHistory` ADD CONSTRAINT `DoctorViewsHistory_historyId_fkey` FOREIGN KEY (`historyId`) REFERENCES `MedicalHistory`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DoctorViewsHistory` ADD CONSTRAINT `DoctorViewsHistory_doctorEmail_fkey` FOREIGN KEY (`doctorEmail`) REFERENCES `Doctor`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;
