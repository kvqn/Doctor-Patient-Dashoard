import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// delete all data from the database

async function deleteAllData() {
  try {
    await prisma.doctorViewsHistory.deleteMany();
    await prisma.docsHaveSchedules.deleteMany();
    await prisma.diagnoses.deleteMany();
    await prisma.patientMedicalHistory.deleteMany();
    await prisma.schedule.deleteMany();
    await prisma.patientsAttendAppointments.deleteMany();
    await prisma.appointment.deleteMany();
    await prisma.doctor.deleteMany();
    await prisma.medicalHistory.deleteMany();
    await prisma.patient.deleteMany();

    console.log('All data deleted successfully!');
  } catch (error) {
    console.error('Error deleting data: ', error);
  } finally {
    await prisma.$disconnect();
  }
}


