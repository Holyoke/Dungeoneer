import React from 'react'
import GreetingContainer from './greeting/greeting_container'

const App = ({children}) => (
  <div>
    <h1>Dungeoneer App Component</h1>
    <GreetingContainer />
    {children}
  </div>
)

export default App
