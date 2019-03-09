document.addEventListener('turbolinks:load', function () {
  var control = document.querySelector('#user_password_confirmation')

  if (control) { control.addEventListener('input', checkPassword) }

})

function checkPassword() {
  var password_confirmation = this.value
  var password = document.querySelector('#user_password').value
  // console.log(password)

  console.log(password_confirmation)

  if (password_confirmation.length == '') {
      document.querySelector('.octicon-x').classList.add('hide')
      document.querySelector('.octicon-verified').classList.add('hide')
      return
  }
  if (password_confirmation != password) {
      document.querySelector('.octicon-x').classList.remove('hide')
      document.querySelector('.octicon-verified').classList.add('hide')
  } else {
      document.querySelector('.octicon-x').classList.add('hide')
      document.querySelector('.octicon-verified').classList.remove('hide')
  }
}
