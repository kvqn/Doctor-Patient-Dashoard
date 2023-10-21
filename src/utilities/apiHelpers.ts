import { AxiosResponse } from 'axios';

// interface of axios response

// export interface AxiosResponse<T = any> {
//   data: T;
//   status: number;
//   statusText: string;
//   headers: any;
//   config: AxiosRequestConfig;
//   request?: any;
// }

// export interface AxiosRequestConfig {
//   url?: string;
//   method?: Method;
//   baseURL?: string;
//   transformRequest?: AxiosTransformer | AxiosTransformer[];
//   transformResponse?: AxiosTransformer | AxiosTransformer[];
//   headers?: any;
//   params?: any;
//   paramsSerializer?: (params: any) => string;
//   data?: any;
//   timeout?: number;
//   timeoutErrorMessage?: string;
//   withCredentials?: boolean;
//   adapter?: AxiosAdapter;
//   auth?: AxiosBasicCredentials;
//   responseType?: ResponseType;
//   xsrfCookieName?: string;
//   xsrfHeaderName?: string;
//   onUploadProgress?: (progressEvent: any) => void;
//   onDownloadProgress?: (progressEvent: any) => void;
//   maxContentLength?: number;
//   validateStatus?: (status: number) => boolean;
//   maxBodyLength?: number;
//   [propName: string]: any;
// }

export const headersProvider = () => {
  const token = localStorage.getItem('token');
  return {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  };
};

export const apiWrap = <T = any>(apiPromise: Promise<AxiosResponse<T>>): Promise<T | undefined> =>
  new Promise(resolve => {
    apiPromise
      .then(res => resolve(res.data))
      .catch(error => {
        resolve(undefined);
        // eslint-disable-next-line no-console
        console.error(error);
      });
  });

// convert above js to ts export const apiWrap
// write similar helpers considering all the cases

export const apiWrapWithoutData = <T = any>(
  apiPromise: Promise<AxiosResponse<T>>
): Promise<AxiosResponse<T> | undefined> =>
  new Promise(resolve => {
    apiPromise
      .then(res => resolve(res))
      .catch(error => {
        resolve(undefined);
        // eslint-disable-next-line no-console
        console.error(error);
      });
  });

export const apiWrapWithoutDataWithError = <T = any>(
  apiPromise: Promise<AxiosResponse<T>>
): Promise<AxiosResponse<T> | undefined> =>
  new Promise(resolve => {
    apiPromise
      .then(res => resolve(res))
      .catch(error => {
        if (error.response) {
          resolve(error.response);
        } else {
          resolve(undefined);
        }
      });
  });

// When using following function, make sure to check data for success, usually a success key
// do not rely on promise resolve
export const apiWrapWithErrorWithData = (apiPromise: Promise<any>) =>
  new Promise(resolve => {
    apiPromise
      .then(res =>
        resolve({
          ...res.data,
          httpCode: res.status,
        })
      )
      .catch(error => {
        if (error.response) {
          resolve({
            ...error.response.data,
            httpCode: error.response.status,
            error: error,
          });
        } else {
          resolve(undefined);
        }
      });
  });
