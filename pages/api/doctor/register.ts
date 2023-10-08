import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/prisma/prisma';
var bcrypt = require('bcryptjs');

// create a new doctor register api
export default async function register(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { email, password, ...otherData } = req.body;

  // Validate email format
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return res.status(400).json({ error: 'Invalid email format.' });
  }

  // Check password strength
  if (password.length < 8) {
    return res.status(400).json({ error: 'Password must be at least 8 characters long.' });
  }

  try {
    // Check if email already exists
    const existingDoctor = await prisma.doctor.findUnique({ where: { email } });
    if (existingDoctor) {
      return res.status(400).json({ error: 'Email already in use.' });
    }

    // Hash the password
    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(password, salt);

    // Store doctor data in the database
    const doctor = await prisma.doctor.create({
      data: {
        email,
        password: hashedPassword, // Store hashed password
        ...otherData,
      },
    });

    // Return the created doctor (exclude sensitive data)
    return res.status(201).json({
      doctor: {
        email: doctor.email,
        name: doctor.name,
        // add other non-sensitive fields if required
      },
    });
  } catch (error) {
    console.error('Registration Error:', error); // Log the detailed error for debugging
    return res.status(400).json({ error: 'Registration failed' });
  }
}
