const helpers = {}

helpers.showErrors = function(data){
  let errors = {};
  if (data == undefined) {
    return errors;
  }
  const messages = data.responseJSON.errors;

  if(messages) {
    for(const key in messages) {
      errors[key] = messages[key].join(', ');
    }
  }

  return errors;
};

export default helpers;
