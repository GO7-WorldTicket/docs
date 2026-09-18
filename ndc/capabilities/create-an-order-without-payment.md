---
layout: go7
title: Create an order without payment
---

# Create an order without payment

**Definition.** Create an order that is held without payment, so the customer can pay later within the airline's time limit.

**Preconditions.** A priced offer from `OfferPrice`, and complete passenger data — names, dates of birth for children and infants, contact email and phone, and travel documents where required.

**Process.** `OrderCreate` with no `PaymentFunctions`

**Post condition.**
- *Success:* an order is created in a held state with an `OrderID` and a booking reference.
- *Failure:* a validation error on passenger or offer data. Check the [error codes](../NDC_API.md#error-code).

**Messages.** [Order Create → Pay later](../endpoints/ordercreate.md#ordercreate-pay-later).

**Notes.** A contact email is required, and dates of birth must be supplied for children and infants.

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
