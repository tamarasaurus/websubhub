# Websubhub

## Subscriber
POST with content type of `application/x-www-form-urlencoded` with the following parameters:
  - `hub.callback`, the subscriber's callback URL that is unique per subscription
  - `hub.mode` - subscribe or unsubscribe
  - `hub.topic` - the topic url that the subscriber wishes to subscribe or unsubscribe to
  - `hub.lease_seconds` - optional, how long it should be active for
  - `hub.secret` - a subscriber provided cryptographically random unique secret string used to compute an HMAC digest (only for https)

### Subscription
  - id [topic_url, callback_url]
  - callback_url
  - ?subscriber
  - topic_url
  - created_at
  - updated_at
  - expire_at

### Implement
- [ ] [TEST] Discovering the hub and topic URLs by looking at the HTTP headers of the resource URL.
- [ ] Subscribing to the hub with a callback URL.
- [ ] Subscribing to the hub and requesting a specific lease duration.
- [ ] Subscribing to the hub with a secret and handling authenticated content distribution.
- [ ] Requesting that a subscription is deactivated by sending an unsubscribe request.
- [ ] The Subscriber acknowledges a pending subscription on a validation request.
- [ ] The Subscriber rejects a subscription validation request for an invalid topic URL.
- [ ] The Subscriber returns an HTTP 2xx response when the payload is delivered.
- [ ] The Subscriber verifies the signature for authenticated content distribution requests.
- [ ] The Subscriber rejects the distribution request if the signature does not validate.
- [ ] The Subscriber rejects the distribution request when no signature is present if the subscription was made with a secret.
- [ ] The Hub respects the requested lease duration during a subscription request.
- [ ] The Hub allows Subscribers to re-request already active subscriptions, extending the lease duration.
- [ ] The Hub sends the full contents of the topic URL in the distribution request.
- [ ] The Hub sends a valid signature for subscriptions that were made with a secret.