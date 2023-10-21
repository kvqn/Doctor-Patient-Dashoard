import Cookies from 'js-cookie';

export const getCookieSession = cookieName => Cookies.get(cookieName);

export const setCookieSession = (cookieName, cookieValue, expiryTime) =>
  Cookies.set(cookieName, cookieValue, { expires: expiryTime });

export const removeCookieSession = cookieName => Cookies.remove(cookieName);
