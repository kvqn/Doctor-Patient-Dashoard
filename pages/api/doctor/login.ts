import prisma from '@/prisma/prisma';
import { NextApiRequest, NextApiResponse } from 'next';
var bcrypt = require('bcryptjs');

// create a new doctor login api
// export async function login(req: NextApiRequest, res: NextApiResponse) {
//   if (req.method === 'POST') {
//     const { email, password } = req.body;
//     try {
//       // Add validation and password hashing here if not done yet

//       const doctor = await prisma.doctor.findUnique({
//         where: {
//           email,
//         },
//       });

//       if (!doctor) {
//         return res.status(400).json({ error: 'No user with that email' });
//       }

//       // Check if password matches
//       if (password === doctor.password) {
//         return res.status(200).json({ doctor });
//       } else {
//         return res.status(400).json({ error: 'Incorrect password' });
//       }
//     } catch (error) {
//       return res.status(400).json({ error: 'Login failed' });
//     }
//   } else {
//     return res.status(405).json({ error: 'Method not allowed' });
//   }
// }

export default async function login(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const { email, password } = req.body;

    try {
      const doctor = await prisma.doctor.findUnique({ where: { email } });

      if (!doctor) {
        return res.status(404).json({ error: 'Doctor not found' });
      }

      // Check if password matches
      console.log('Provided password:', password);

      const isPasswordValid = bcrypt.compareSync(password, doctor.password);
      console.log('Stored hashed password:', doctor.password);
      if (!isPasswordValid) {
        if (password !== doctor.password) {
          return res.status(400).json({ error: 'Incorrect password' });
        }
      }

      console.log('Comparison result:', isPasswordValid);
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
