import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/prisma/prisma';
var bcrypt = require('bcryptjs');

export default async function register(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { email, password, ...otherData } = req.body;

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return res.status(400).json({ error: 'Invalid email format.' });
  }

  if (password.length < 8) {
    return res.status(400).json({ error: 'Password must be at least 8 characters long.' });
  }

  try {
    const existingPatient = await prisma.patient.findUnique({ where: { email } });
    if (existingPatient) {
      return res.status(400).json({ error: 'Email already in use.' });
    }

    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(password, salt);

    const patient = await prisma.patient.create({
      data: {
        email,
        password: hashedPassword,
        ...otherData,
      },
    });

    return res.status(201).json({
      patient: {
        email: patient.email,
        name: patient.name,
      },
    });
  } catch (error) {
    console.error('Registration Error:', error);
    return res.status(400).json({ error: 'Registration failed' });
  }
}
