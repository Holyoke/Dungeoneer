import React from 'react'
import { Link } from 'react-router'

const personalGreeting = (currentUser, logout) => (
  <div>
    <h3>Welcome, currentUser.name!</h3>
    <button onClick={logout}>Log out</button>
  </div>
)

const sessionLinks = () => (
  <Link to="/login">Login</Link>
)

const Greeting = ({currentUser, logout}) => (
  currentUser ? personalGreeting(currentUser, logout) : sessionLinks()
)

export default Greeting
