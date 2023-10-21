import axios from 'axios';
import { apiWrapWithErrorWithData } from './apiHelpers';

interface ILoginData {
  email: string;
  password: string;
}

interface IRegisterData {
  email: string;
  gender: string;
  password: string;
  name: string;
  phoneNo?: string | undefined;
}

export const doctorLoginApi = (data: ILoginData) =>
  axios.post('/doctor/login', {
    email: data.email,
    password: data.password,
  });

export const doctorRegisterApi = (data: IRegisterData) =>
  axios.post('/doctor/register', {
    email: data.email,
    gender: data.gender,
    password: data.password,
    name: data.name,
    phoneNo: data.phoneNo,
  });
