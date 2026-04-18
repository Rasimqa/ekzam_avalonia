using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ekzam_avalonia.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext()
    {
    }

    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Appointment> Appointments { get; set; }

    public virtual DbSet<BalanceTransaction> BalanceTransactions { get; set; }

    public virtual DbSet<Collection> Collections { get; set; }

    public virtual DbSet<Master> Masters { get; set; }

    public virtual DbSet<MasterReview> MasterReviews { get; set; }

    public virtual DbSet<MasterService> MasterServices { get; set; }

    public virtual DbSet<QualificationRequest> QualificationRequests { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Service> Services { get; set; }

    public virtual DbSet<ServiceReview> ServiceReviews { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=exam_db;Username=postgres;Password=123");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Appointment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("appointments_pkey");

            entity.ToTable("appointments");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AppointmentDate)
                .HasColumnType("timestamp without time zone")
                .HasColumnName("appointment_date");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.MasterId).HasColumnName("master_id");
            entity.Property(e => e.QueueNumber).HasColumnName("queue_number");
            entity.Property(e => e.ServiceId).HasColumnName("service_id");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasDefaultValueSql("'active'::character varying")
                .HasColumnName("status");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Master).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.MasterId)
                .HasConstraintName("appointments_master_id_fkey");

            entity.HasOne(d => d.Service).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.ServiceId)
                .HasConstraintName("appointments_service_id_fkey");

            entity.HasOne(d => d.User).WithMany(p => p.Appointments)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("appointments_user_id_fkey");
        });

        modelBuilder.Entity<BalanceTransaction>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("balance_transactions_pkey");

            entity.ToTable("balance_transactions");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Amount)
                .HasPrecision(10, 2)
                .HasColumnName("amount");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.TransactionDate)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("transaction_date");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.BalanceTransactions)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("balance_transactions_user_id_fkey");
        });

        modelBuilder.Entity<Collection>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("collections_pkey");

            entity.ToTable("collections");

            entity.HasIndex(e => e.Name, "collections_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Master>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("masters_pkey");

            entity.ToTable("masters");

            entity.HasIndex(e => e.UserId, "masters_user_id_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.HireDate)
                .HasDefaultValueSql("CURRENT_DATE")
                .HasColumnName("hire_date");
            entity.Property(e => e.Qualification)
                .HasDefaultValue(1)
                .HasColumnName("qualification");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.User).WithOne(p => p.Master)
                .HasForeignKey<Master>(d => d.UserId)
                .HasConstraintName("masters_user_id_fkey");
        });

        modelBuilder.Entity<MasterReview>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("master_reviews_pkey");

            entity.ToTable("master_reviews");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Comment).HasColumnName("comment");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.MasterId).HasColumnName("master_id");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Master).WithMany(p => p.MasterReviews)
                .HasForeignKey(d => d.MasterId)
                .HasConstraintName("master_reviews_master_id_fkey");

            entity.HasOne(d => d.User).WithMany(p => p.MasterReviews)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("master_reviews_user_id_fkey");
        });

        modelBuilder.Entity<MasterService>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("master_services_pkey");

            entity.ToTable("master_services");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.MasterId).HasColumnName("master_id");
            entity.Property(e => e.ServiceId).HasColumnName("service_id");

            entity.HasOne(d => d.Master).WithMany(p => p.MasterServices)
                .HasForeignKey(d => d.MasterId)
                .HasConstraintName("master_services_master_id_fkey");

            entity.HasOne(d => d.Service).WithMany(p => p.MasterServices)
                .HasForeignKey(d => d.ServiceId)
                .HasConstraintName("master_services_service_id_fkey");
        });

        modelBuilder.Entity<QualificationRequest>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("qualification_requests_pkey");

            entity.ToTable("qualification_requests");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.MasterId).HasColumnName("master_id");
            entity.Property(e => e.ProcessedByModeratorId).HasColumnName("processed_by_moderator_id");
            entity.Property(e => e.RequestDate)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("request_date");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasDefaultValueSql("'pending'::character varying")
                .HasColumnName("status");

            entity.HasOne(d => d.Master).WithMany(p => p.QualificationRequests)
                .HasForeignKey(d => d.MasterId)
                .HasConstraintName("qualification_requests_master_id_fkey");

            entity.HasOne(d => d.ProcessedByModerator).WithMany(p => p.QualificationRequests)
                .HasForeignKey(d => d.ProcessedByModeratorId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("qualification_requests_processed_by_moderator_id_fkey");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("roles_pkey");

            entity.ToTable("roles");

            entity.HasIndex(e => e.Name, "roles_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Service>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("services_pkey");

            entity.ToTable("services");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CollectionId).HasColumnName("collection_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.LastModifiedDate)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("last_modified_date");
            entity.Property(e => e.Name)
                .HasMaxLength(200)
                .HasColumnName("name");
            entity.Property(e => e.Price)
                .HasPrecision(10, 2)
                .HasColumnName("price");

            entity.HasOne(d => d.Collection).WithMany(p => p.Services)
                .HasForeignKey(d => d.CollectionId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("services_collection_id_fkey");
        });

        modelBuilder.Entity<ServiceReview>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("service_reviews_pkey");

            entity.ToTable("service_reviews");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Comment).HasColumnName("comment");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.ServiceId).HasColumnName("service_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Service).WithMany(p => p.ServiceReviews)
                .HasForeignKey(d => d.ServiceId)
                .HasConstraintName("service_reviews_service_id_fkey");

            entity.HasOne(d => d.User).WithMany(p => p.ServiceReviews)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("service_reviews_user_id_fkey");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("users_pkey");

            entity.ToTable("users");

            entity.HasIndex(e => e.Login, "users_login_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Balance)
                .HasPrecision(10, 2)
                .HasDefaultValueSql("0")
                .HasColumnName("balance");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.FullName)
                .HasMaxLength(200)
                .HasColumnName("full_name");
            entity.Property(e => e.Login)
                .HasMaxLength(100)
                .HasColumnName("login");
            entity.Property(e => e.Password)
                .HasMaxLength(100)
                .HasColumnName("password");
            entity.Property(e => e.RoleId).HasColumnName("role_id");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone")
                .HasColumnName("updated_at");

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("users_role_id_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
