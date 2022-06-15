import jester
echo "startup..."

const TRUSTED = @["00"]

func trustedCheck(token: string): bool =
  if token in TRUSTED:
    return true
  else:
    return false

routes:
  get "/":
    resp "Hello, World!"

  get "/getsub":
    resp "sub"

  get "/getsub/@sub_id":
    resp "sub : " & @"sub"

  post "/postsub/@token":
    if not trustedCheck(@"token"):
      resp "unauthorized"
    var push = @"payload"
    resp "post sub : " & push

  delete "/getsub/@sub_id/@token":
    if not trustedCheck(@"token"):
      resp "unauthorized"
    resp "delete sub : " & @"sub"





