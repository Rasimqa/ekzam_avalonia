using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class Master
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int? Qualification { get; set; }

    public DateOnly? HireDate { get; set; }

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual ICollection<MasterReview> MasterReviews { get; set; } = new List<MasterReview>();

    public virtual ICollection<MasterService> MasterServices { get; set; } = new List<MasterService>();

    public virtual ICollection<QualificationRequest> QualificationRequests { get; set; } = new List<QualificationRequest>();

    public virtual User User { get; set; } = null!;
}
