import React from 'react'
import ReactDOM from 'react-dom'
import configureStore from './store/store'
import Root from './components/root'

// Testing
import * as actions from './actions/session_actions'

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore()
  const root = document.getElementById('root')
  window.store = store
  window.actions = actions
  window.buildstamp = new Date().toLocaleTimeString()
  ReactDOM.render(<Root store={store} />, root)
})
