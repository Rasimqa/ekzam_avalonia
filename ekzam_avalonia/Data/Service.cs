using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class Service
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public decimal Price { get; set; }

    public int? CollectionId { get; set; }

    public DateTime? LastModifiedDate { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public virtual Collection? Collection { get; set; }

    public virtual ICollection<MasterService> MasterServices { get; set; } = new List<MasterService>();

    public virtual ICollection<ServiceReview> ServiceReviews { get; set; } = new List<ServiceReview>();
}
