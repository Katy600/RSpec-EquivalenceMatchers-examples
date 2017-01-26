# What are test doubles?

Test doubles are an object that we use during testing that stands in for another object.

### So why use test doubles?

We use them when the real object is difficult to work with. Maybe it's "expensive" to work with, that is, maybe it requires going to the database and doing a lot of setup, or maybe it requires that we have an internet connection so that we can connect to a remote server. We don't necessarily want to have to run our tests only when we're connected to the internet. Or it might be that the responses from the real object are unpredictable.

Having fixed, expected responses is going to make testing easier.

### Common examples of where you might use test doubles
- If you wanted to send email. You might not actually want the email to go out, but you would want to act as though you were sending the email out.


- Interacting with an API.

### So what do test doubles do in RSpec?
- They set known return values
- They fake method implementations,
- They set expectations about calls to an object.

## Definitions
 A "double" or a "mock" is going to be a simple object that's preprogrammed with expectations and responses as preparation for the calls that it will receive. That's what it is, it's an object. There's another term which is "stub," and we're going to be using that a lot as well. Stub is an instruction to an object to return a specific response to a method call. So we have a double or a mock object, and it has many stubs on it.
