### Ad-hoc workflow pattern

This IG uses the [FHIR R4 ad-hoc workflow pattern](https://hl7.org/fhir/R4/workflow-ad-hoc.html). The ambulance system (sender) constructs a `ServiceRequest` and transmits it to the HAP system (receiver), which acts on the request directly - there is no separate coordination resource mediating between the two parties. This pattern is independent of the exchange paradigm: how the resources are packaged and transported (see the [Data Exchange](data-exchange.html) page) is a separate, not-yet-decided question.

This matches the operational reality of the ambulance-to-HAP referral: it is a one-shot handover. The ambulance crew sends the referral and the HAP receives it. There is an acceptance moment, but it runs out of band: the referral is discussed by telephone, and the decision whether the patient goes to this HAP is taken during that call. The message itself therefore carries no protocol-level back-and-forth and no receiver-side acceptance status. What the sender does track is its own *Bestemmingsstatus*, in `ServiceRequest.status`. The `ServiceRequest` carries `intent` with the pattern *order*, and the roles are fixed: the ambulance is the `requester`, the HAP is the `performer`.

### Why no Task

FHIR defines `Task` as the resource for tracking the fulfillment of a request. It is appropriate when a workflow needs explicit state of transitions `status` (*requested*, *accepted*, *in-progress*, *completed*, *rejected*), delegation to another party, or a fulfilment record that lives independently of the original request.

None of those are required here. The transaction has no receiver-side status, so a `Task` would have no data to carry, while it would introduce coordination overhead and a resource to maintain on both sides. The profiles are therefore intentionally designed without it.

The trigger for revisiting this is a change in the functional design, not in the profiles: as soon as the transaction gains a receiver-side response - accepted or rejected, with a reason - `Task` becomes the resource that carries it. Counting those responses also requires a return channel from receiver to sender, which the current one-directional PUSH does not have; that depends on the exchange paradigm. See the [Open Items](open-items.html) page.

### How Task could fit in the future

If a future version of this use case, or a different acute care use case, requires richer workflow semantics, a `Task` can be introduced without reworking the referral content. The pattern would be:

- The sender creates a `Task` with `Task.intent` set to *order* and `Task.basedOn` referencing the `ServiceRequest`.
- The receiver updates `Task.status` as the referral moves through its lifecycle (e.g. *received*, *accepted*, *in-progress*, *completed*).
- If the receiver cannot fulfill the request, it sets `Task.status` to *rejected* and populates `Task.statusReason`.
- Delegation to a third party (e.g. the HAP forwarding to a GP) can be modeled with a child `Task` linked via `Task.partOf`.

Because the `ServiceRequest` and its content profiles are unchanged in this scenario, the referral data itself does not need to be versioned or reworked. The `Task` layer is purely additive.
