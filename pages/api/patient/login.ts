// similarly create a login api for patient

import prisma from '@/prisma/prisma';
import { NextApiRequest, NextApiResponse } from 'next';
var bcrypt = require('bcryptjs');

// Path: pages/api/patient/login.ts

export default async function login(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const { email, password } = req.body;

    try {
      const patient = await prisma.patient.findUnique({ where: { email } });

      if (!patient) {
        return res.status(404).json({ error: 'patient not found' });
      }

      // Check if password matches
      const isPasswordValid = bcrypt.compareSync(password, patient.password);
      if (!isPasswordValid) {
        if (patient.password !== password) {
          return res.status(400).json({ error: 'Incorrect password' });
        }
      }
      // Validate the password (compare with hashed version)
      // If valid, generate a token or set a session

      return res.status(200).json({ message: 'Login successful' });
    } catch (error) {
      return res.status(400).json({ error: 'Login failed' });
    }
  } else {
    return res.status(405).json({ error: 'Method not allowed' });
  }
}
