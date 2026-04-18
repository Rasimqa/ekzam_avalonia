using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class User
{
    public int Id { get; set; }

    public string Login { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string FullName { get; set; } = null!;

    public int RoleId { get; set; }

    public decimal? Balance { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual ICollection<BalanceTransaction> BalanceTransactions { get; set; } = new List<BalanceTransaction>();

    public virtual Master? Master { get; set; }

    public virtual ICollection<MasterReview> MasterReviews { get; set; } = new List<MasterReview>();

    public virtual ICollection<QualificationRequest> QualificationRequests { get; set; } = new List<QualificationRequest>();

    public virtual Role Role { get; set; } = null!;

    public virtual ICollection<ServiceReview> ServiceReviews { get; set; } = new List<ServiceReview>();
}
