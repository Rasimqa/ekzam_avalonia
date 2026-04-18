using System;
using System.Collections.Generic;

namespace ekzam_avalonia.Data;

public partial class MasterReview
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int MasterId { get; set; }

    public int? Rating { get; set; }

    public string? Comment { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Master Master { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
