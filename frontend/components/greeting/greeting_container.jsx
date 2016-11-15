import { connect } from 'react-redux'
import Greeting from './greeting'
import { logout } from '../../actions/session_actions'

const mapStateToProps = ({ currentUser }) => ({
  currentUser
})

const mapDispatchToProps = dispatch => ({
  logout: user => dispatch(logout(user))
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Greeting)
