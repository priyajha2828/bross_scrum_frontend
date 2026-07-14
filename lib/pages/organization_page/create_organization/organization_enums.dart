/// Mirrors the Prisma `PlanTier` enum.
enum PlanTier { free, standard, premium, enterprise }

/// Mirrors the Prisma `SubscriptionStatus` enum.
enum SubscriptionStatus { trialing, active, pastDue, canceled }

extension PlanTierX on PlanTier {
  /// Value sent to / received from the backend (matches Prisma enum name).
  String get apiValue {
    switch (this) {
      case PlanTier.free:
        return 'FREE';
      case PlanTier.standard:
        return 'STANDARD';
      case PlanTier.premium:
        return 'PREMIUM';
      case PlanTier.enterprise:
        return 'ENTERPRISE';
    }
  }

  String get label {
    switch (this) {
      case PlanTier.free:
        return 'Free';
      case PlanTier.standard:
        return 'Standard';
      case PlanTier.premium:
        return 'Premium';
      case PlanTier.enterprise:
        return 'Enterprise';
    }
  }

  String get tagline {
    switch (this) {
      case PlanTier.free:
        return 'Get started with the basics';
      case PlanTier.standard:
        return 'For growing teams';
      case PlanTier.premium:
        return 'Advanced tools & priority support';
      case PlanTier.enterprise:
        return 'Custom limits & dedicated support';
    }
  }

  String get priceLabel {
    switch (this) {
      case PlanTier.free:
        return '\$0/mo';
      case PlanTier.standard:
        return '\$12/mo';
      case PlanTier.premium:
        return '\$29/mo';
      case PlanTier.enterprise:
        return 'Custom';
    }
  }

  List<String> get features {
    switch (this) {
      case PlanTier.free:
        return const ['Up to 5 members', '1 project', 'Community support'];
      case PlanTier.standard:
        return const ['Up to 25 members', 'Unlimited projects', 'Email support'];
      case PlanTier.premium:
        return const ['Up to 100 members', 'Integrations & webhooks', 'Priority support'];
      case PlanTier.enterprise:
        return const ['Unlimited members', 'SSO & audit logs', 'Dedicated success manager'];
    }
  }

  bool get isPopular => this == PlanTier.standard;

  static PlanTier fromApiValue(String value) {
    switch (value) {
      case 'STANDARD':
        return PlanTier.standard;
      case 'PREMIUM':
        return PlanTier.premium;
      case 'ENTERPRISE':
        return PlanTier.enterprise;
      case 'FREE':
      default:
        return PlanTier.free;
    }
  }
}

extension SubscriptionStatusX on SubscriptionStatus {
  String get apiValue {
    switch (this) {
      case SubscriptionStatus.trialing:
        return 'TRIALING';
      case SubscriptionStatus.active:
        return 'ACTIVE';
      case SubscriptionStatus.pastDue:
        return 'PAST_DUE';
      case SubscriptionStatus.canceled:
        return 'CANCELED';
    }
  }
}