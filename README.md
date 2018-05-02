# Websubhub

[![Build Status](https://travis-ci.org/tamarasaurus/websubhub.svg?branch=master)](https://travis-ci.org/tamarasaurus/websubhub) [![Coverage Status](https://coveralls.io/repos/github/tamarasaurus/websubhub/badge.svg?branch=master)](https://coveralls.io/github/tamarasaurus/websubhub?branch=master)


## Subscriber
POST with content type of `application/x-www-form-urlencoded` with the following parameters:
  - `hub.callback`, the subscriber's callback URL that is unique per subscription
  - `hub.mode` - subscribe or unsubscribe
  - `hub.topic` - the topic url that the subscriber wishes to subscribe or unsubscribe to
  - `hub.lease_seconds` - optional, how long it should be active for
  - `hub.secret` - a subscriber provided cryptographically random unique secret string used to compute an HMAC digest (only for https)

### Subscription
  - id (internal)
  - [topic_url, callback_url] as the primary key
  - created_at
  - updated_at
  - expired_at

### Todo
- [x] Enforce [topic_url,callback_url] as a real id in the database
- [ ] Create root hub controller
    - [ ] `GET /` - Use HAL to represent availble operations
    - [ ] `POST /` - Publish topic updates and distribute contents to subscribers

### Implement
- [ ] Discovering the hub and topic URLs by looking at the HTTP headers of the resource URL.
- [ ] Discovering the hub and topic URLs by looking at the contents of the resource URL as an XML document.
- [ ] Discovering the hub and topic URLs by looking at the contents of the resource URL as an HTML document.
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
- [ ] The Hub sends a diff of the topic URL for the formats that support it.
- [ ] The Hub sends a valid signature for subscriptions that were made with a secret.

### Generate

- subscription `mix phx.gen.schema Subscription subscriptions topic_url:string callback_url:string expired_at:naive_datetime\`

### Run tests

- mix test --cover