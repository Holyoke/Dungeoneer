import { applyMiddleware } from 'redux';
import sessionMiddleware from './session_middleware';

const RootMiddleware = applyMiddleware(
  sessionMiddleware
);

export default RootMiddleware;
