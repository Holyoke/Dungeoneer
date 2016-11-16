import React from 'react'
import ReactDOM from 'react-dom'
import configureStore from './store/store'
import Root from './components/root'

// Testing
import * as actions from './actions/session_actions'

document.addEventListener('DOMContentLoaded', () => {
  let store

  if (window.currentUser) {
    const preloadedState = {session: {currentUser: window.currentUser}}
    store = configureStore(preloadedState)
  } else {
    store = configureStore()
  }

  // testing
  window.store = store
  window.actions = actions
  window.buildstamp = new Date().toLocaleTimeString()

  const root = document.getElementById('root')
  ReactDOM.render(<Root store={store} />, root)
})
