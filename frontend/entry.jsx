import React from 'react'
import ReactDOM from 'react-dom'
import configureStore from './store/store'
import Root from './components/root'

// Testing
import * as actions from './actions/session_actions'

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore()
  const root = document.getElementById('root')
  window.actions = actions
  window.buildtime = new Date().toLocaleTimeString()
  ReactDOM.render(<Root store={store} />, root)
})
