import {
  receiveCurrentUser,
  receiveErrors,
  LOGIN,
  LOGOUT
} from '../actions/session_actions'

import { login, logout } from '../util/session_api_util';

const sessionMiddleware = ({ getState, dispatch }) => next => action => {
  const successCallback = user => dispatch(receiveCurrentUser(user));
  const errorCallback = xhr => dispatch(receiveErrors(xhr.responseJSON));

  switch(action.type) {
    case LOGIN:
      login(action.user, successCallback, errorCallback);
      var result = next(action);
      return result
    case LOGOUT:
      logout(action.user);
      next(action);
      break;
    default:
      return next(action);
  }
}

export default sessionMiddleware;
