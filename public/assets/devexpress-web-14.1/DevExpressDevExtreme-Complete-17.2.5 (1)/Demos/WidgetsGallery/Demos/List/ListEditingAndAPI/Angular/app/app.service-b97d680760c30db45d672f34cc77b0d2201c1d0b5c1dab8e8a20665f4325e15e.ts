import { Injectable } from '@angular/core';

let tasks: string[] = ["Prepare 2016 Financial", "Prepare 2016 Marketing Plan", "Update Personnel Files", "Review Health Insurance Options Under the Affordable Care Act", "New Brochures", "2016 Brochure Designs", "Brochure Design Review", "Website Re-Design Plan", "Rollout of New Website and Marketing Brochures",
    "Update Sales Strategy Documents", "Create 2012 Sales Report", "Direct vs Online Sales Comparison Report", "Review 2012 Sales Report and Approve 2016 Plans", "Deliver R&D Plans for 2016",
    "Create 2016 R&D Plans", "2016 QA Strategy Report", "2016 Training Events", "Approve Hiring of John Jeffers", "Non-Compete Agreements", "Update NDA Agreement", "Update Employee Files with New NDA", "Sign Updated NDA",
    "Submit Questions Regarding New NDA", "Submit Signed NDA", "Update Revenue Projections", "Review Revenue Projections", "Comment on Revenue Projections", "Provide New Health Insurance Docs",
    "Review Changes to Health Insurance Coverage", "Scan Health Insurance Forms", "Sign Health Insurance Forms", "Follow up with West Coast Stores", "Follow up with East Coast Stores",
    "Send Email to Customers about Recall", "Submit Refund Report for 2016 Recall", "Give Final Approval for Refunds", "Prepare Product Recall Report", "Review Product Recall Report by Engineering Team",
    "Create Training Course for New TVs", "Review Training Course for any Ommissions", "Review Overtime Report", "Submit Overtime Request Forms", "Overtime Approval Guidelines", "Refund Request Template",
    "Recall Rebate Form", "Create Report on Customer Feedback", "Review Customer Feedback Report", "Customer Feedback Report Analysis", "Prepare Shipping Cost Analysis Report", "Provide Feedback on Shippers",
    "Select Preferred Shipper", "Complete Shipper Selection Form", "Upgrade Server Hardware", "Upgrade Personal Computers", "Approve Personal Computer Upgrade Plan", "Decide on Mobile Devices to Use in the Field",
    "Upgrade Apps to Windows RT or stay with WinForms", "Estimate Time Required to Touch-Enable Apps", "Report on Tranistion to Touch-Based Apps", "Try New Touch-Enabled WinForms Apps",
    "Rollout New Touch-Enabled WinForms Apps", "Site Up-Time Report", "Review Site Up-Time Report", "Review Online Sales Report", "Determine New Online Marketing Strategy", "New Online Marketing Strategy",
    "Approve New Online Marketing Strategy", "Submit New Website Design", "Create Icons for Website", "Review PSDs for New Website", "Create New Shopping Cart", "Create New Product Pages", "Review New Product Pages",
    "Approve Website Launch", "Launch New Website", "Update Customer Shipping Profiles", "Create New Shipping Return Labels", "Get Design for Shipping Return Labels", "PSD needed for Shipping Return Labels",
    "Request Bandwidth Increase from ISP", "Submit D&B Number to ISP for Credit Approval", "Contact ISP and Discuss Payment Options", "Prepare Year-End Support Summary Report", "Analyze Support Traffic for 2016",
    "Review New Training Material", "Distribute Training Material to Support Staff", "Training Material Distribution Schedule", "Provide New Artwork to Support Team", "Publish New Art on the Server",
    "Replace Old Artwork with New Artwork", "Ship New Brochures to Field", "Ship Brochures to Todd Hoffman", "Update Server with Service Packs", "Install New Database", "Approve Overtime for HR",
    "Review New HDMI Specification", "Approval on Converting to New HDMI Specification", "Create New Spike for Automation Server", "Report on Retail Sales Strategy for 2014", "Code Review - New Automation Server",
    "Feedback on New Training Course", "Send Monthly Invoices from Shippers", "Schedule Meeting with Sales Team", "Confirm Availability for Sales Meeting", "Reschedule Sales Team Meeting", "Send 2 Remotes for Giveaways",
    "Ship 2 Remotes Priority to Clark Morgan", "Discuss Product Giveaways with Management", "Follow Up Email with Recent Online Purchasers", "Replace Desktops on the 3rd Floor", "Update Database with New Leads",
    "Mail New Leads for Follow Up", "Send Territory Sales Breakdown", "Territory Sales Breakdown Report", "Return Merchandise Report", "Report on the State of Engineering Dept", "Staff Productivity Report",
    "Review HR Budget Company Wide", "Sales Dept Budget Request Report", "Support Dept Budget Report", "IT Dept Budget Request Report", "Engineering Dept Budget Request Report", "1Q Travel Spend Report",
    "Approve Benefits Upgrade Package", "Final Budget Review", "State of Operations Report", "Online Sales Report", "Reprint All Shipping Labels", "Shipping Label Artwork", "Specs for New Shipping Label",
    "Move Packaging Materials to New Warehouse", "Move Inventory to New Warehouse", "Take Forklift to Service Center", "Approve Rental of Forklift", "Give Final Approval to Rent Forklift", "Approve Overtime Pay",
    "Approve Vacation Request", "Approve Salary Increase Request", "Review Complaint Reports", "Review Website Complaint Reports", "Test New Automation App", "Fix Synchronization Issues", "Free Up Space for New Application Set",
    "Install New Router in Dev Room", "Update Your Profile on Website", "Schedule Conf Call with SuperMart", "Support Team Evaluation Report", "Create New Installer for Company Wide App Deployment",
    "Pickup Packages from the Warehouse", "Sumit Travel Expenses for Recent Trip", "Make Travel Arrangements for Sales Trip to San Francisco", "Book Flights to San Fran for Sales Trip",
    "Collect Customer Reviews for Website", "Submit New W4 for Updated Exemptions", "Get New Frequent Flier Account", "Review New Customer Follow Up Plan", "Submit Customer Follow Up Plan Feedback",
    "Review Issue Report and Provide Workarounds", "Contact Customers for Video Interviews", "Resubmit Request for Expense Reimbursement", "Approve Vacation Request Form", "Email Test Report on New Products",
    "Send Receipts for all Flights Last Month"
];


@Injectable()
export class Service {
    getTasks() : string[] {
        return tasks;
    }
}
