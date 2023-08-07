# ioh_invoices_services

## Description
Frontend developers need an invoice RESTful API for them to develop on web applications, so users can create invoices using web applications.

## Feature/Specs
Must have Authentication API for restrict Invoice resources
### Invoice Creation
- As a User, I should be able to create invoice with items
- Invoice should have many invoice items
- Mandatory fields : user, invoice number, due date, item
name and qty
- Total should be calculated automatically and stored in a
database field
### Invoice update
- As a User, I should be able to update invoice with items
- New total amount should be calculated automatically
### Invoice deletion
- User should be able to delete invoice
- All related invoices items should be deleted also
### Invoice listing
- As a User, I should be able to see all my invoices with
pagination
### Invoice details
- As a User, I should be able to see detail of my invoice
along with its items

## Tech Specification
- Use Web Framework
- SQL database (mysql/postgres/sqlite)
- Provide README how to run locally
