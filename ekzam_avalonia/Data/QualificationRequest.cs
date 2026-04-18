using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class QualificationRequest
{
    public int Id { get; set; }

    public int MasterId { get; set; }

    public DateTime? RequestDate { get; set; }

    public string? Status { get; set; }

    public int? ProcessedByModeratorId { get; set; }

    public virtual Master Master { get; set; } = null!;

    public virtual User? ProcessedByModerator { get; set; }
}
