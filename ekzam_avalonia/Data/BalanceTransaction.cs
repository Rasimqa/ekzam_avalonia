using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class BalanceTransaction
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public decimal Amount { get; set; }

    public DateTime? TransactionDate { get; set; }

    public string? Description { get; set; }

    public virtual User User { get; set; } = null!;
}
