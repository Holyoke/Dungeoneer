export const login = (user, success, error) => {
  $.ajax({
    url: '/api/v1/session/',
    type: 'POST',
    data: user,
    success,
    error
  })
}

export const logout = (data, success, error) => {
  $.ajax({
    url: '/api/v1/session/',
    type: 'DELETE',
    data: data,
    success,
    error
  })
}

export const signup = (data, success, error) => {
  $.ajax({
    url: '/api/v1/session/',
    type: 'DELETE',
    data: data,
    success,
    error
  })
}
