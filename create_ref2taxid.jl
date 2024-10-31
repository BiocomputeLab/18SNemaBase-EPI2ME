# ================================================================================
# Generate a ref2taxid file for a curated 18S nematode sequence database. This is
# compatible with the wf-metagenomics EPI2ME workflow.
#
# Use minimap2 as the aligner, 18S_NemaBase.mmi as the reference and the generated
# ref2taxid.txt as the `--ref2taxid` option.
#
# Author: Thomas E. Gorochowski <tom@chofski.co.uk>
# ================================================================================

function load_taxid2name(filename)
    mapping = Dict()
    open(filename) do io
        for line in readlines(io)
            columns = split(strip(line), "|")
            if length(columns) > 1
                mapping[strip(columns[2])] = strip(columns[1])
            end
        end
    end
    return mapping
end

function create_ref2taxid(ref_filename, name2taxid, out_filename)
    output = ""
    open(ref_filename) do io
        for line in readlines(io)
            ref = strip(line)
            columns = split(ref, ";")
            if length(columns) > 1
                species = strip(replace(columns[end], "_" => " "))
                if species in keys(name2taxid)
                    taxid = name2taxid[species]
                    output *= ref[2:end] * "\t" * taxid * "\n"
                else
                    # If taxid is not found then use "other sequences"
                    taxid = "28384"
                    output *= ref[2:end] * "\t" * taxid * "\n"
                    println("$(species): not found in taxid mapping set to 28384.")
                end
            end
        end
    end
    open(out_filename, "w") do io
        write(io, output)
    end
end

name2taxid = load_taxid2name("taxid2name.txt")
create_ref2taxid("18S_NemaBase.fasta", name2taxid, "ref2taxid_18S_NemaBase.txt")
