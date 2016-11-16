import { connect } from 'react-redux'
import { login } from '../../actions/session_actions'
import SessionForm from './session_form'

const mapStateToProps = ({ session }) => ({
  loggedIn: Boolean(session.currentUser),
  errors: session.errors
})

const mapDispatchToProps = (dispatch, {location}) => {
  const formType = location.pathname.slice(1)
  const processForm = (formType === 'login') ? login : ''

  return {
    processForm: (user) => dispatch(processForm(user))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(SessionForm)