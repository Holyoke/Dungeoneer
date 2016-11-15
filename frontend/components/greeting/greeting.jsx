import React from 'react'
import { Link } from 'react-router'

const personalGreeting = (currentUser, logout) => (
  <div>
    <h3>Welcome, {currentUser.email}!</h3>
    <button onClick={logout}>Log out</button>
  </div>
)

const sessionLinks = () => {
  return (
    <Link to="/login">Login</Link>
  )
}

const Greeting = ({currentUser, logout}) => {
  return (
    currentUser ? personalGreeting(currentUser, logout) : sessionLinks(logout)
  )
}

export default Greeting
