module ARValidation
  EMAIL_RE = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/ix
  URI_RE = /^(http|https):\/\/(localhost|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5})((:[0-9]{1,5})?\/.*)?$/ix
end
