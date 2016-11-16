import React from 'react'
import { Provider } from 'react-redux'
import { Router, Route, hashHistory } from 'react-router'

// components
import App from './App'
import SessionFormContainer from './session_form/session_form_container'

const Root = ({store}) => {
  return (
    <Provider store={store} >
      <Router history={hashHistory}>
        <Route path="/" component={App}>
          <Route path="/login" component={SessionFormContainer} />
        </Route>
      </Router>
    </Provider>
  )
}

export default Root
