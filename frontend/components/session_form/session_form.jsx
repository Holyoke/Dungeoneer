import React from 'react'
import { Link, withRouter } from 'react-router'

class SessionForm extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      email: '',
      password: ''
    }
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleSubmit (e) {
    e.preventDefault()
    const session = this.state
    this.props.processForm({session})
  }

  renderErrors () {
    return (
      <ul>
				{this.props.errors.map((error, i) => (
          <li key={`error-${i}`}>
            {error}
          </li>
				))}
        </ul>
		)
  }

  redirectIfLoggedIn () {
    if (this.props.loggedIn) {
      this.props.router.push('/')
    }
  }

  update (field) {
    return (e) => this.setState({
      [field]: e.currentTarget.value
    })
  }

  navLink () {
    if (this.props.formType === 'login') {
      return <a href="/signup">sign up instead</a>
    } else {
      return <Link to="/login">log in instead</Link>
    }
  }

  render () {
    return (
      <div className="login-form-container">
        <form onSubmit={this.handleSubmit} className="login-form-box">
          Dungeoneer!
          <br />
          Please {this.props.formType} or {this.navLink()}
          {this.renderErrors()}
          <div className="login-form">
            <br />
            <label> Username:
              <input type="text"
                value={this.state.email}
                onChange={this.update('email')}
                />
            </label>
            <br />
            <label> Password:
              <input type="password"
                value={this.state.password}
                onChange={this.update('password')}
                />
            </label>
            <br />
            <input type="submit" value="Submit" />
          </div>
        </form>
      </div>
    )
  }
}

export default SessionForm
