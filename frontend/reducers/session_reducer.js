import { LOGIN,
         LOGOUT,
         RECEIVE_CURRENT_USER,
         RECEIVE_ERRORS } from '../actions/session_actions'

import merge from 'lodash/merge'

const SessionReducer = (state = {currentUser: null, errors: []}, action) => {
  Object.freeze(state)

  let newState = merge({}, state)

  switch (action.type) {
    case 'RECEIVE_CURRENT_USER':
      newState.currentUser = action.user
      newState.errors = []

      return newState
    case 'RECEIVE_ERRORS':
      window.alert(action.errors)
      newState.errors = action.errors

      return newState
    case 'LOGOUT':
      newState.errors = []
      newState.currentUser = null

      return newState
    default:
      return state
  }
}

export default SessionReducer
