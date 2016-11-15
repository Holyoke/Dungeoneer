import React from 'react'
import GreetingContainer from './greeting/greeting'

const App = ({children}) => (
  <div>
    <h1>Dungeoneer App Component</h1>
    <GreetingContainer />
    {children}
  </div>
)

export default App
