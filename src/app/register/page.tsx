import prisma from '@/prisma/prisma';
import { v4 as uuid4 } from 'uuid';
async function createUser(formData: FormData) {
  'use server';

  console.log(formData);

  const email = formData.get('email') as string;
  const password = formData.get('password') as string;

  if (!email) return;
  if (!password) return;

  const id = uuid4();

  await prisma.user.create({
    data: {
      email: email,
      id: id,
      password: password,
    },
  });
}

export default function Page() {
  return (
    <form action={createUser}>
      <label>
        Email:
        <input type="text" name="email" />
      </label>
      <label>
        Password:
        <input type="password" name="password" />
      </label>
      <input type="submit" value="Create User" />
    </form>
  );
}
