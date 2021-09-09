Rails.configuration.stripe={
    :publishable_key => "pk_test_51JUa3ND958u3TM4MuK2vuUQpjRANmKmlWQknyFbM7KzGw63tUQwaPQe0QHXzZTssGfknqqyAXhoNQV4vB3qXvNgw00QP3ZsV5q",
    :secret_key => "sk_test_51JUa3ND958u3TM4MUhmywyHB3PuyQtC5x3ULBSTSX9sBy45eWX9K8x2XuweDwTVN1HPUBmAjFjeY9EQs2wQvMXcP003rsdXoY9"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]