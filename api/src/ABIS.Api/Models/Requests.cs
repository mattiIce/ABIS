namespace Abis.Api.Models;

// Write request bodies. Kept separate from the read models so the public write
// contract is explicit and never silently widened by adding read columns.

/// <summary>Create or fully replace a customer. <see cref="CustomerName"/> is required.</summary>
public sealed class CustomerWrite
{
    public string? CustomerName { get; set; }
    public string? CustomerShortName { get; set; }
    public string? EnduserName { get; set; }
    public string? ShiptoCustomerZip { get; set; }
}

/// <summary>Partial update of a production job. Null fields are left unchanged
/// (PATCH semantics via COALESCE) — a field cannot be cleared to null this way.</summary>
public sealed class JobPatch
{
    public int? JobStatus { get; set; }
    public string? JobNotes { get; set; }
    public int? NumberOfMenUsed { get; set; }
    public DateTime? TimeDateFinished { get; set; }
}

/// <summary>Partial update of a coil (inventory move / status change). Null fields
/// are left unchanged.</summary>
public sealed class CoilPatch
{
    public int? CoilStatus { get; set; }
    public string? CoilLocation { get; set; }
    public string? CoilNotes { get; set; }
}
