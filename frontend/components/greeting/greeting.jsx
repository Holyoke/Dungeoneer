import React from 'react'
import { Link } from 'react-router'

const personalGreeting = (currentUser, logout) => {
  debugger
  return (
    <div>
      <h3>Welcome, {currentUser.email}!</h3>
      <button onClick={logout}>Log out</button>
    </div>
  )
}

const sessionLinks = () => {
  return (
    <div>
      <p>Not logged in</p>
      <Link to="/login">Login Plz</Link>
      <a href="/users/sign_in">Login manually here</a>
    </div>
  )
}

const Greeting = ({currentUser, logout}) => {
  return (
    currentUser ? personalGreeting(currentUser, logout) : sessionLinks(logout)
  )
}

export default Greeting
